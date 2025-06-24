from testing import assert_equal, assert_true, assert_false
from pegra.expression import PChar, PAny, PNot, PSeq, POre

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

fn test_pnot_matches() raises:
    var pnot = PNot(PChar("a"))
    var actual = pnot.matches("abc")
    assert_false(actual)

fn test_pnot_not_matches() raises:
    var pnot = PNot(PChar("b"))
    var actual = pnot.matches("abc")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("abc"))

fn test_pseq_matches() raises:
    var pseq = PSeq(PChar("a"), PChar("b"))
    var actual = pseq.matches("abc")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("c"))

fn test_pseq_not_matches() raises:
    var pseq = PSeq(PChar("a"), PChar("c"))
    var actual = pseq.matches("abc")
    assert_false(actual)

fn test_pore_matches_1() raises:
    var pore = POre(PChar("a"), PChar("b"))
    var actual = pore.matches("abc")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("bc"))

fn test_pore_matches_2() raises:
    var pore = POre(PChar("a"), PChar("b"))
    var actual = pore.matches("bac")
    assert_true(actual)
    assert_equal(actual.value(), StringSlice("ac"))

fn test_pore_not_matches() raises:
    var pore = PSeq(PChar("a"), PChar("b"))
    var actual = pore.matches("cab")
    assert_false(actual)
