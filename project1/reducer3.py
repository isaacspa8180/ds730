import sys 
from collections import Counter, defaultdict


# def main(argv):
#     d = defaultdict(list)
#     for line in iter(sys.stdin.readline, ''):
#         line = line.strip()
#         k, vs = line.split('\t', 1)
#         vs = vs.split(' ')
#         vs = {int(v) for v in vs}
#         d[k].append(vs)
#     print(d)


def main(argv):
    all_friend_friends = defaultdict(list)
    my_friends = defaultdict(set)
    for line in iter(sys.stdin.readline, ''):
        line = line.strip()
        me, network = line.split('\t', 1)
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
    print(count_not_my_friends)

    might_know = defaultdict(list)
    for me, not_friends in count_not_my_friends.items():
        for not_friend, cnt in not_friends.items():
            if cnt >= 2:
                might_know[me].append(not_friend)
    # print(might_know)


    # prob_know = defaultdict(list)
    # for not_friend, cnt in count_not_my_friends.items():
    #     if int(cnt) > 4:
    #         prob_know[me].append(not_friend)


if __name__ == '__main__':
    main(sys.argv)