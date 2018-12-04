#!/usr/bin/env python
import math
import sys
from itertools import permutations


def main(argv):
    #create cache of cost for each arc
    cost_map = {}
    building_name = []
    for row_num, line in enumerate(iter(sys.stdin.readline, '')):
        head, tail = line.strip().split(" : ")
        building_name.append(head)
        costs = tail.split(" ")
        for col_num, cost in enumerate(costs):
            if row_num == col_num:
                continue
            arc = row_num, col_num
            cost_map[arc] = float(cost)
    #get all permutations without the start and end
    middle = range(1, len(building_name))
    middle_perm = list(permutations(middle))
    #add back the start and end node
    possible_trips = [tuple([0] + list(perm) + [0]) for perm in middle_perm]
    #find min
    min_trip_cost = math.inf
    trip_map = {}
    for trip in possible_trips:
        trip_cost = 0
        #add the cost of each arc
        for node in range(len(trip) - 1):
            arc = trip[node], trip[node + 1]
            trip_cost += cost_map[arc]
        #cache the results
        trip_map[trip] = trip_cost
        if trip_cost < min_trip_cost:
            min_trip_cost = trip_cost
    #print trips that match min
    for trip, cost in trip_map.items():
        if cost == min_trip_cost:
            print([building_name[node] for node in trip])


if __name__ == '__main__':
    main(sys.argv)
