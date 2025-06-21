from testing import assert_equal, assert_true
from pegra.expression import PChar

fn test_pchar() raises:
    var pchar = PChar("foo")
    var actual = pchar.matches("foobar")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("bar"))
