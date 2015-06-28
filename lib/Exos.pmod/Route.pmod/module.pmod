#define E(X) werror(sprintf("%t: %O\n", X, X));

object _route;

public string match(mixed... args) {
  if(!objectp(_route))
    _route= Route();
  return _route->match(@args);
}

public mixed is_route(mixed... args) {
  if(!objectp(_route))
    _route= Route();
  return _route->is_route(@args);
}

class Route {
  void create() {
    if(master()->objects["routes"] == 0)
      master()->objects["routes"] = ([]);
  }
  public mixed is_route(mixed... args) {
    return master()->objects["routes"][args[0]];
  }
  public int match(mixed... args) {
    return master()->objects["routes"][args[0]] = args[1];
  }
}
