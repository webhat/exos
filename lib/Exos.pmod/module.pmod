#define VERSION "0.0.1"
#define E(X) werror(sprintf("%t: %O\n", X, X));

class Exos {
  public mapping(string:function) _main = ([ ]);

  public int cmd_server(mapping(string:string) args) {
    write("Starting server...\n");
    ExosServer();
    return -1;
  }

  public int cmd_routes(mapping(string:string) args) {
    write("\t\t\t%=*s %=-*s %-=*s\n", 6, "method" , 30, "path", 70/2, "controller");
    mixed all_routes = .Route.all_routes();
    foreach(indices(all_routes), string path) {
      mixed controller = all_routes[path];
      write("\t\t\t%=*s %=-*s %-=*O\n", 6, "GET" , 30, path, 70/2, controller);
    }
    return 0;
  }

  public int cmd_client(mapping(string:string) args) {
    write("Starting client...\n");
    ExosClient();
    return 0;
  }

  public int cmd_generate(mapping(string:string) args) {
    ExosTemplates()->generate(args);
    return 0;
  }

  public int start(mapping(string:string) args) {
    return _main[args["service"]]( args );
  }

  void create() {
    foreach(indices(this), string func_name) {
      if( functionp(this[func_name]) && search(func_name, "cmd_") == 0) {
        _main[func_name[4..255]] = this[func_name];
        string short = sprintf("%c",func_name[4]);
        if( !functionp(_main[short])) _main[short] = this[func_name];
      }
    }
  }
}

class ExosServer {
  void create() {
    Protocols.HTTP.Server.Port(this->handle_request, 8080);
  }

  void handle_request(Protocols.HTTP.Server.Request request) {
    if(!.Route.is_route(request->not_query))
      request->response_and_finish( (["data":
            this->file_not_found(request->not_query),
            "type":"text/html",
            "error":Protocols.HTTP.HTTP_NOT_FOUND]) );
    else
      request->response_and_finish( (["data":
            this->file_found(request->not_query),
            "type":"text/html",
            "error":Protocols.HTTP.HTTP_FOUND]) );
  }

  string file_not_found(string filename) {
    return
      "<html><body><h1>File not found</h1>\n"
      "<tt>" + Parser.encode_html_entities(filename) + "</tt><br />\n"
      "</body></html>\n";
  }

  string file_found(string filename) {
    return
      "<html><body><h1>File found</h1>\n"
      "<tt>" + Parser.encode_html_entities(filename) + "</tt><br />\n"
      "</body></html>\n";
  }
}

class ExosClient {
  inherit Tools.Hilfe.StdinHilfe;

  void print_version() {
    safe_write("Exos " VERSION " "+ version()+
        " running Hilfe v3.5 (Incremental Pike Frontend)\n");
    int major = master()->compat_major;
    int minor = master()->compat_minor;
    if( major!=-1 || minor!=-1 )
      safe_write("(running in Pike %d.%d compat mode)\n", major, minor);
  }
}

class ExosTemplates {
  mapping _template = ([
      0:default_template,
      "model":model,
      "view":view,
      "controller":controller,
      ]);

  public int generate(mapping(string:string) args) {
    _template[args[ "name" ]](args);
  }
  private int default_template(mapping args) {
    string name = args["name"] || "unnamed";

    write(sprintf("Couldn't find generator for `%s'\n", name));
  }
  private int model(mapping args) { default_template(args); }
  private int view(mapping args) { default_template(args); }
  private int controller(mapping args) { default_template(args); }
}

public int start(mapping(string:string) args) {
  Exos()->start(args);
}
