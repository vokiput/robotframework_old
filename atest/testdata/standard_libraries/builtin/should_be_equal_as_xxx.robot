*** Test Cases ***
Should Be Equal As Integers
    [Documentation]    FAIL 100 != 101
    [Template]    Should Be Equal As Integers
    100       100
    100       ${100}
    ${100}    ${100.1}
    100       ${100.1}
    100       101

Should Be Equal As Integers with base
    [Documentation]    Conversion functionality tested with `Convert To Integer`
    [Template]    Should Be Equal As Integers
    ABCD    abcd    base=16
    0b10    2
    0xFF    0o377
    0b0     0
    0x0     0o0
    0b1     1
    0x1     0o1

Should Not Be Equal As Integers
    [Documentation]    FAIL This message only
    [Template]    Should Not Be Equal As Integers
    1    0
    0    ${1}
    1    ${1}    This message only    No values

Should Not Be Equal As Integers with base
    [Documentation]    Conversion functionality tested with `Convert To Integer`
    [Template]    Should Not Be Equal As Integers
    ABC     DEF    base=16
    0b10    10
    0x10    0o10

Should Be Equal As Numbers
    [Documentation]    FAIL Only this message
    [Template]    Should Be Equal As Numbers
    1    1.0000
    1    1.0001    Only this message    False

Should Be Equal As Numbers with precision
    [Documentation]    FAIL Failure: 110.0 != 150.0
    [Template]    Should Be Equal As Numbers
    1.123       1.456      precision=0
    1.123       ${1.1}     precision=1
    ${1.123}    ${1.12}    precision=2
    1123        1456       precision=-3
    112         145        precision=-2
    112         145        precision=-1    msg=Failure

Should Not Be Equal As Numbers
    [Documentation]    FAIL Fails again: 1.0 == 1.0
    [Template]    Should Not Be Equal As Numbers
    1.1    1.2
    1      ${1.2}
    1.0    1    Fails again

Should Not Be Equal As Numbers with precision
    [Documentation]    FAIL Failing: 1.0 == 1.0
    [Template]    Should Not Be Equal As Numbers
    1.123       1.456      precision=1
    1.123       ${1.1}     precision=2
    ${1.123}    ${1.12}    precision=3
    1123        1456       precision=-2
    112         145        precision=-1
    1.12        1.45       precision=0    msg=Failing

Should Be Equal As Strings
    [Documentation]    FAIL foo != bar
    [Template]    Should Be Equal As Strings
    ${1}       1
    ${None}    None    repr=whatever
    foo        bar

Should Be Equal As Strings does NFC normalization
    [Template]    Should Be Equal As Strings
    Å     A\u030A
    Å     \u212B

Should Be Equal As Strings case-insensitive
    [Documentation]    FAIL yötä != päivää
    [Template]    Should Be Equal As Strings
    test value    TEST VALUE    ignore_case=True
    HYVÄÄ YÖTÄ    hyvää yötä    repr=yes    ignore_case=yes
    YÖTÄ          PÄIVÄÄ        ignore_case=True

Should Be Equal As Strings without leading spaces
    [Documentation]    FAIL Several failures occurred:
    ...
    ...    1) YÖTÄ != yötä
    ...
    ...    2) test\t != test
    [Template]    Should Be Equal As Strings
    San Diego        San Diego        strip_spaces=leading
    ${SPACE * 5}1    ${SPACE}${1}     strip_spaces=Leading
    ${SPACE}test     \ttest           strip_spaces=LEADING
    test\ \ value    test\ \ value    strip_spaces=leading
    ${SPACE}yötä     \työtä           repr=yes    strip_spaces=leading
    ${SPACE}         ${EMPTY}         strip_spaces=leading
    \t\nYÖTÄ         \t\nyötä         strip_spaces=leading
    ${SPACE}test\t   test             strip_spaces=leading

Should Be Equal As Strings without trailing spaces
    [Documentation]    FAIL Several failures occurred:
    ...
    ...    1) YÖTÄ != yötä
    ...
    ...    2) ${SPACE}test != test
    [Template]    Should Be Equal As Strings
    San Diego          San Diego          strip_spaces=Trailing
    1${SPACE * 5}      ${1}${SPACE}       strip_spaces=trailing
    \ttest\tvalue\t    \ttest\tvalue\t    strip_spaces=TRAILING
    test\tvalue        test\tvalue        strip_spaces=trailing
    yötä${SPACE}       yötä\t             repr=yes    strip_spaces=trailing
    ${SPACE}           ${EMPTY}           strip_spaces=trailing
    YÖTÄ\n\t           yötä\t\n           strip_spaces=trailing
    ${SPACE}test\t     test               strip_spaces=trailing

Should Be Equal As Strings without leading and trailing spaces
    [Documentation]    FAIL Several failures occurred:
    ...
    ...    1) YÖTÄ != PÄIVÄÄ
    ...
    ...    2) \ test 1\t != \ttest 1\t
    [Template]    Should Be Equal As Strings
    San Diego                San Diego       strip_spaces=TRUE
    \tHelsinki               Helsinki\t      strip_spaces=truE
    1${SPACE * 5}            \t${1}          strip_spaces=Yes
    \ttest\tvalue${SPACE}    test\tvalue     strip_spaces=true
    test                     \ttest\t        strip_spaces=true
    ${SPACE}HYVÄÄ\t          \tHYVÄÄ\t       repr=yes    strip_spaces=True
    ${SPACE}                 ${EMPTY}        strip_spaces=True
    \tYÖTÄ\n\t               \n\ PÄIVÄÄ\t    strip_spaces=True
    ${SPACE}test 1\t         \ttest 1\t      strip_spaces=Okay

Should Be Equal As Strings repr
    [Documentation]    FAIL Several failures occurred:
    ...
    ...    1) NB != NB
    ...
    ...    2) 'NB' != 'NB\\x00'
    [Template]    Should Be Equal As Strings
    NB    NB\x00
    NB    NB\x00      formatter=repr

Should Be Equal As Strings multiline
    [Documentation]    FAIL
    ...    Multiline strings are different:
    ...    --- first
    ...    +++ second
    ...    @@ -1,3 +1,4 @@
    ...   \ foo
    ...    -bar
    ...    +bar
    ...    +gar
    ...   \ dar
    Should Be Equal As Strings    foo\nbar\r\ndar    foo\nbar\ngar\ndar

Should Be Equal As Strings repr multiline
    [Documentation]    FAIL
    ...    Multiline strings are different:
    ...    --- first
    ...    +++ second
    ...    @@ -1,3 +1,4 @@
    ...   \ 'foo\\n'
    ...    -'bar\\r\\n'
    ...    +'bar\\n'
    ...    +'gar\\n'
    ...   \ 'dar'
    Should Be Equal As Strings    foo\nbar\r\ndar    foo\nbar\ngar\ndar    formatter=repr

Should Not Be Equal As Strings
    [Documentation]    FAIL These strings most certainly should not be equal
    [Template]    Should Not Be Equal As Strings
    1        ${1.1}
    False    ${True}
    bar      bar    These strings most certainly should not be equal    False

Should Not Be Equal As Strings case-insensitive
    [Documentation]    FAIL true == true
    [Template]    Should Not Be Equal As Strings
    1        ${1.1}     ignore_case=True
    Hyvää    päivää     ignore_case=yes
    true     ${True}    ignore_case=yeah

Should Not Be Equal As Strings without leading spaces
    [Documentation]     FAIL Several failures occurred:
    ...
    ...    1) 1 == 1
    ...
    ...    2) Hyvää == Hyvää
    [Template]    Should Not Be Equal As Strings
    \t1       ${1}             strip_spaces=leading
    Hyvää     ${SPACE}Hyvää    strip_spaces=Leading
    \ttest    ${SPACE}test     strip_spaces=yeah
    \n2\t     ${SPACE}2\n\t    strip_spaces=LEADING

Should Not Be Equal As Strings without trailing spaces
    [Documentation]     FAIL Several failures occurred:
    ...
    ...    1) 1 == 1
    ...
    ...    2) Hyvää == Hyvää
    [Template]    Should Not Be Equal As Strings
    1\t       ${1}             strip_spaces=trailing
    Hyvää     Hyvää${SPACE}    strip_spaces=Trailing
    test\t    test${SPACE}     strip_spaces=yeah
    \t2\n     \n\t2\n          strip_spaces=TRAILING

Should Not Be Equal As Strings without leading and trailing spaces
    [Documentation]     FAIL Several failures occurred:
    ...
    ...    1) 1 == 1
    ...
    ...    2) Hyvää == Hyvää
    [Template]    Should Not Be Equal As Strings
    \t1${SPACE}    \t${1}\t          strip_spaces=True
    \tHyvää        Hyvää\t           strip_spaces=Yes
    \ttest\t       \ttest${SPACE}    strip_spaces=yeah
