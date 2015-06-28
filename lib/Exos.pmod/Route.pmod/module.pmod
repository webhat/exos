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

public mixed resources(mixed... args) {
  if(!objectp(_route))
    _route= Route();
  return _route->resources(@args);
}

mapping(string:string) all_routes() {
  mapping(string:string) routes = ([]);
  foreach(indices(master()->objects["routes"]), string path) {
    mixed controller = master()->objects["routes"][path];
    routes[path] = sprintf("%O", controller);
  }
  return routes;
}

class Route {
  void create() {
    if(master()->objects["routes"] == 0)
      master()->objects["routes"] = ([]);
  }
  public mixed is_route(mixed... args) {
    string path = get_path(args[0]);
    return master()->objects["routes"][path];
  }
  public mixed match(mixed... args) {
    string path = get_path(args[0]);
    master()->objects["routes"][path] = (["GET":args[1]]);
    return master()->objects["routes"][path];
  }
  public mixed resources(mixed... args) {
    string path = get_path(args[0]);
    master()->objects["routes"][path] = (["GET":args[1]]);
    master()->objects["routes"][path] += (["POST":args[1]]);
    master()->objects["routes"][path +"/:id"] = (["GET":args[1]]);
    master()->objects["routes"][path +"/:id"] += (["PUT":args[1]]);
    master()->objects["routes"][path +"/:id/edit"] = (["GET":args[1]]);
    master()->objects["routes"][path +"/:id"] += (["DELETE":args[1]]);
    return master()->objects["routes"][path];
  }

  private string get_path(string _path) {
    if(_path[-1] == '/')
      return _path[0..sizeof(_path)-2];
    else
      return _path;
  }
}
