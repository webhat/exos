import Tests;

int testExpectToEq() {
  expect("testing")->to()->eq("testing");
}

int testExpectToNotEq() {
  expect("testing")->to_not()->eq("testingx");
}

void testExpect() {
  expect(Expect)->to()->be(Expect);
}

void testRouteRoute() {
  string controllername = "/test1";
  Exos.Route.match(controllername, Object);
  expect(Exos.Route.is_route(controllername)["GET"])->to()->be(Object);
}

void testRouteRouteInstantiale() {
  string controllername = "/test2";
  Exos.Route.match(controllername, Controllers.TestController);
  program root = Exos.Route.is_route(controllername)["GET"];
  expect(root)->to()->be(Controllers.TestController);
}

void testRouteResourceIndex() {
  string controllername = "/test_index";
  Exos.Route.resources(controllername, Controllers.TestController);
  program index = Exos.Route.is_route(controllername)["GET"]();
  expect(index->index)->to()->eq(0);

}

void testRouteResourceShow() {
  string controllername = "/test_show";
  Exos.Route.resources(controllername, Controllers.TestController);
  program show = Exos.Route.is_route(controllername +"/:id")["GET"]();
  expect(show->show)->to()->eq(0);

}

void testRouteResourceEdit() {
  string controllername = "/test_edit";
  Exos.Route.resources(controllername, Controllers.TestController);
  program edit = Exos.Route.is_route(controllername +"/:id/edit")["GET"]();
  expect(edit->edit)->to()->eq(0);

}

void testRouteResourceUpdate() {
  string controllername = "/test_update";
  Exos.Route.resources(controllername, Controllers.TestController);
  program update = Exos.Route.is_route(controllername +"/:id")["PUT"]();
  expect(update->update)->to()->eq(0);

}

void testRouteResourceCreate() {
  string controllername = "/test_create";
  Exos.Route.resources(controllername, Controllers.TestController);
  program create = Exos.Route.is_route(controllername +"/")["POST"]();
  expect(create->create)->to()->eq(0);

}

void testRouteResourceDestroy() {
  string controllername = "/test_destroy";
  Exos.Route.resources(controllername, Controllers.TestController);
  program destroy = Exos.Route.is_route(controllername +"/:id")["DELETE"]();
  expect(destroy->destroy)->to()->eq(0);
}

void testRouteRouteShow() {
  pending();
  string controllername = "/test3";
  Exos.Route.match(controllername, Controllers.TestController);
  program root = Exos.Route.is_route(controllername)();
  expect(root->show)->to()->eq("");
}
