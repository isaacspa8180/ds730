#!/usr/bin/python

import sys 
from collections import Counter, defaultdict


def main(argv):
    all_friend_friends = defaultdict(list)
    my_friends = defaultdict(set)
    for line in iter(sys.stdin.readline, ''):
        line = line.strip()
        me, network = line.split('\t', 1)
        me = int(me)
        friend, friend_friends = network.split(',')
        friend_friends = set(friend_friends.split(' '))
        if me == friend:
            my_friends[me] = friend_friends
        else:
            all_friend_friends[me].append(friend_friends)

    not_my_friends = defaultdict(list)
    for me, list_friend_friends in all_friend_friends.items():
        for friend_friends in list_friend_friends:
            not_my_friends[me].append(friend_friends.difference(my_friends[me]))

    count_not_my_friends = defaultdict(list)        
    for me, list_friend_friends in not_my_friends.items():
        flat_list = []
        for friend_friends in list_friend_friends:
            for friend in friend_friends:
                flat_list.append(friend)
        count_not_my_friends[me] = Counter(flat_list)

    might_know = defaultdict(list)
    for me, not_friends in count_not_my_friends.items():
        for not_friend, cnt in not_friends.items():
            if cnt >= 2 and cnt < 4:
                might_know[me].append(not_friend)

    prob_know = defaultdict(list)
    for me, not_friends in count_not_my_friends.items():
        for not_friend, cnt in not_friends.items():
            if cnt >= 4:
                prob_know[me].append(not_friend)

    for k in sorted(not_my_friends):
        if might_know[k] and not prob_know[k]:
            print('{0}:Might({1})'.format(k, ','.join(might_know[k])))
        if might_know[k] and prob_know[k]:
            print('{0}:Might({1}) Probably({2})'.format(k, ','.join(might_know[k]), ','.join(prob_know[k])))
        if not might_know[k] and prob_know[k]:
            print('{0}:Probably({1})'.format(k, ','.join(prob_know[k])))
        if not might_know[k] and not prob_know[k]:
            print('{0}:'.format(k))




if __name__ == '__main__':
    main(sys.argv)
