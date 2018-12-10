val text = sc.textFile("input2.txt")
val head_tail = text.map(_.trim.split(" : "))
val building_name = head_tail
  .map(_.head)
  .collect
val costs = head_tail
  .flatMap(_.tail)
  .map(_.split(" "))
  .collect
var cost_map = Map[(Int, Int), Double]()
var i = 0
for (_ <- building_name) {
    var j = 0
    for (cost <- costs(i)) {
        cost_map += ((i, j) -> cost.toDouble)
        j += 1
    }
    i += 1
}
val middle_perm = (1 to building_name.length - 1).toList.permutations.toArray
val possible_trips = middle_perm.map(List(0) ++ _ ++ List(0))
var min_trip_cost = 9999.0
var trip_map = Map[List[Int], Double]()
for (trip <- possible_trips) {
    var trip_cost = 0.0
    for (node <- 0 to trip.length - 2) {
        val arc = (trip(node), trip(node + 1))
        trip_cost += cost_map(arc)
    }
    trip_map += (trip -> trip_cost)
    if (trip_cost < min_trip_cost) {
        min_trip_cost = trip_cost
    }
}
val p = new java.io.PrintWriter("output2.txt")
p.println(min_trip_cost)
for ((trip, cost) <- trip_map) {
    if (cost == min_trip_cost) {
        p.println(trip.map(building_name(_)))
    }
}
p.flush
p.close
