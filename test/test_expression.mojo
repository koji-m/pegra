from testing import assert_equal, assert_true, assert_false
from pegra.expression import PChar, PAny

fn test_pchar_matches() raises:
    var pchar = PChar("foo")
    var actual = pchar.matches("foobar")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("bar"))

fn test_pchar_not_matches() raises:
    var pchar = PChar("foo")
    var actual = pchar.matches("barbaz")
    assert_false(actual)

fn test_pany_matches() raises:
    var pany = PAny()
    var actual = pany.matches("abc")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("bc"))

fn test_pany_not_matches() raises:
    var pany = PAny()
    var actual = pany.matches("")
    assert_false(actual)
