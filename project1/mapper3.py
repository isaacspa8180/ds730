import sys 


# def main(argv):
#     for line in iter(sys.stdin.readline, ''):
#         line = line.strip()
#         me, friends = line.split(' : ', 1)
#         print('{0}\t{1},{2}'.format(me, me, friends))
#         for friend in friends.split(' '):
#             print('{0}\t{1},{2}'.format(friend, me, friends))


def main(argv):
    for line in iter(sys.stdin.readline, ''):
        line = line.strip()
        me, friends = line.split(' : ', 1)
        print('{0}\t{1},{2}'.format(me, me, friends))
        list_friends = friends.split(' ')
        for friend in list_friends:
            list_friends.remove(friend)
            print('{0}\t{1},{2}'.format(friend, me, ' '.join(list_friends)))


if __name__ == '__main__':
    main(sys.argv)