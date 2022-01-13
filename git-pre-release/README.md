# git-pre-release

## extending git

### git-pre-release
Create a alpha/beta/rc tag when in a release branch.

#### Copy the script file to:
```
# make file executable
chmod u+x ./git-pre-release.sh
# copy to location
cp ./git-pre-release.sh ~/usr/local/bin
```

#### Usage
```
git pre-release [-t] [-m] [-i] [-h]

Create tag for pre-releases
-----------------------------------------------------------
-t | --type          Type of pre-release: alpha, beta or rc
-m | --message       Message for the tag
-i | --iterate       Flag to iterate previous tag
-h | --help          Print usage
-----------------------------------------------------------
```

