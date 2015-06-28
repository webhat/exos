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
  expect(Exos.Route.match(controllername, Object))->to()->be(Object);
  expect(Exos.Route.is_route(controllername))->to()->be(Object);
}

void testRouteRouteInstantiale() {
  string controllername = "/test2";
  Exos.Route.match(controllername, Controllers.TestController);
  program root = Exos.Route.is_route(controllername);
  expect(root)->to()->be(Controllers.TestController);
}

void testRouteRouteShow() {
  pending();
  string controllername = "/test3";
  Exos.Route.match(controllername, Controllers.TestController);
  program root = Exos.Route.is_route(controllername)();
  expect(root->show)->to()->eq("");
}
