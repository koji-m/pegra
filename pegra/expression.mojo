trait PExpression(Copyable, Movable):
    fn matches[org: ImmutableOrigin](self, seq: StringSlice[org]) -> Optional[StringSlice[org]]:
        pass

@fieldwise_init
struct PChar(PExpression):
    var text: String

    fn matches[org: ImmutableOrigin](self, seq: StringSlice[org]) -> Optional[StringSlice[org]]:
        var txt = self.text.as_string_slice()
        if seq.startswith(txt):
            var txt_len = Int(txt.char_length())
            return Optional[StringSlice[org]](seq[txt_len:])
        else:
            return Optional[StringSlice[org]](None)

@fieldwise_init
struct PAny(PExpression):
    fn matches[org: ImmutableOrigin](self, seq: StringSlice[org]) -> Optional[StringSlice[org]]:
        if len(seq) > 0:
            return Optional[StringSlice[org]](seq[1:])
        return Optional[StringSlice[org]](None)

@fieldwise_init
struct PNot[T: PExpression](PExpression):
    var exp: T

    fn matches[org: ImmutableOrigin](self, seq: StringSlice[org]) -> Optional[StringSlice[org]]:
        var m = self.exp.matches(seq)
        if not m:
            return seq
        return Optional[StringSlice[org]](None)

@fieldwise_init
struct PSeq[T1: PExpression, T2: PExpression](PExpression):
    var exp1: T1
    var exp2: T2

    fn matches[org: ImmutableOrigin](self, seq: StringSlice[org]) -> Optional[StringSlice[org]]:
        var m = self.exp1.matches(seq)
        if not m:
            return Optional[StringSlice[org]](None)
        return self.exp2.matches(m.value())
