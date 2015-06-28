#define E(X) werror(sprintf("%t: %O\n", X, X));
import Controllers;
import Exos;
import Tests;

void testRouteRoot() {
  expect(Route.is_route("/"))->to()->be(TestController);
}

void testRouteInstantiale() {
  program root = Route.is_route("/");
  expect(root())->to_not()->be(TestController());
}
