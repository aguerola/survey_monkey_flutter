from termcolor import colored
import requests


def get_version(package_name):
    try:
        url = 'https://pub.dev/packages/{name}#-installing-tab-'.format(name=package_name)
        # resp = urllib.request.urlopen(url)
        resp = requests.get(url, verify=True)
        # print(str(resp.content.decode("utf-8") ))
        page = resp.content.decode("utf-8")

        preceding_text = "<h2 class=\"title\">{name} ".format(name=package_name)
        index = page.find(preceding_text)
        index = index + len(preceding_text)

        if index == -1:
            return None

        # print(page)
        line = page[index: index + 20]
        # print(line)
        end = line.find("</h2>")
        return line[0: end]
    except:
        return None

    # print(result)


name = 'shared_preferences'
# print(get_version(name))

# filepath = '/Users/antonio/Programming/android/AndroidStudioProjects/be_green_flutter/be_green_flutter/pubspec.yaml'
filepath = 'pubspec.yaml'

with open(filepath) as fp:
    for cnt, line in enumerate(fp):
        if ': ^' in line and line.strip()[0] != '#':
            index = line.find(': ^')
            name = line[0:index].strip()
            version = line[index + 3:len(line) - 1]

            latest_version = get_version(name)

            if version != latest_version:
                same_chars = 0
                for i in range(0, min(len(version), len(latest_version))):
                    if version[i] == latest_version[i]:
                        same_chars = same_chars + 1
                    else:
                        break
                s = colored(name + " ", 'blue')
                s = s + version[0:same_chars] + colored(version[same_chars:], 'red')
                s = s+colored(" ==> ", 'grey')
                s = s + latest_version[0:same_chars] + colored(latest_version[same_chars:], 'green')

                print(s)


