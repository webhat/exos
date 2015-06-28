#define E(X) werror(sprintf("%t: %O\n", X, X));

public object expect(mixed actual) {
  object expect;
  mixed err = catch {
    expect = Expect(actual);
  };
  if(err) { werror(sprintf("Trace: %O\n", err)); }
  return expect;
}

void pending() {
  throw(Pending(backtrace()));
}

class Pending {
  void create(mixed bt) {
  }
}

class TestsFail {
  inherit Error.Generic;
  void create(string name, mixed... args) {
    werror(sprintf("Expected %t `%O' to %s %t `%O'\n", args[0], args[0], name, args[1], args[1]));
    mixed last_arg = args[sizeof(args)-1];
    if(arrayp(last_arg))
      werror(pretty_backtrace(last_arg));
  }
}

class Expect {
  private mixed actual;
  private mixed modifier;
  private string test = "eq";
  void create(mixed _actual) {
    actual = _actual;
  }

  public object to() {
    modifier = true;
    return this;
  }

  public object to_not() {
    modifier = false;
    return this;
  }

  public object eq(mixed expected) {
    if(modifier) {
      if (expected != actual) {
        throw(TestsFail(test, expected, actual, backtrace()));
      }
    } else {
      if (expected == actual) {
        throw(TestsFail(test, expected, actual, backtrace()));
      }
    }
    return this;
  }

  public object be(mixed expected) {
    test = "be";
    return eq(expected);
  }
}

string pretty_backtrace(mixed err) {
  string error_message = "Error:\n";
  if(arrayp(err) && sizeof(err) == 2) {
    error_message += err[0];
    string bt = "";
    for(int i; i < sizeof(err[1]); i++) {
      bt = sprintf("\t%O\n%s", err[1][i], bt);
    }
    error_message += bt;
  }
  return error_message;
}
