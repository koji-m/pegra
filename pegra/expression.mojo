trait PExpression:
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