import inspect, os
import urllib
import subprocess

#TODO
# get solarized theme from actual github, not mine


#Installation settings
config = {}
config["macvim"] = True
config["vimrc"] = True
config["repo"] = True
config["bashprofile"] = True

filename = inspect.getfile(inspect.currentframe())
print "Setting up your new machine. Settings are in this file %s" % (filename)

#global vars, I know it's ugly ;)
brewInstalled = None
homeDir = os.path.expanduser("~")

def checkBrew():
  global brewInstalled
  if brewInstalled is None:
    try:
      print 'checking if brew is installed...'
      with open(os.devnull, "w") as fnull:
        result = subprocess.call("brew", stderr=fnull, stdout=fnull)
        print "brew detected"
        brewInstalled = True
    except OSError:
      brewInstalled = False
      print "homebrew is not installed, exiting"
      exit()
  return brewInstalled

def installBrewPackage(package):
  global config
  if config[package] is not True:
    print "%s disabled in config" % (package)
    return
  print 'Installing brew package %s' % (package)
  with open(os.devnull) as fnull:
    command = ["brew", "install", package]
    result = subprocess.call(command)
    if result == 0:
      print 'brew installed "%s" successfully' % (package)
    else:
      print 'failed to install %s' % (package)
      exit()

def cloneGitRepo(gitUrl):
  if gitUrl[-4:] != '.git':
    print "Not a git repo? %s" % (gitUrl)
    exit()
  gitrepo = gitUrl[gitUrl.rindex('/')+1 : -4]
  if not os.path.exists(gitrepo):
    print "trying to clone git repo %s" % (gitrepo)
    rv = subprocess.call(["git", "clone", gitUrl])
    if rv is not 0:
      print "Failed to install git repo %s" % (gitUrl)
      exit()
    return (True, gitrepo)
  return (False, gitrepo)

def installVimPackage(gitUrl):
  pwd = os.getcwd()
  os.chdir(homeDir + "/.vim/bundle")
  (res, repo) = cloneGitRepo(gitUrl)
  if not res:
    print "Package already installed %s" % (repo)
  os.chdir(pwd)

def installVimFiles():
  makedirs(homeDir + "/.vim/autoload")
  makedirs(homeDir + "/.vim/bundle")
  if not os.path.exists(homeDir + "/.vim/autoload/pathogen.vim"):
    urllib.urlretrieve("https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim", homeDir + "/.vim/autoload/pathogen.vim")
  # Now for the packages
  installVimPackage("https://github.com/scrooloose/nerdtree.git")
  installVimPackage("https://github.com/altercation/vim-colors-solarized.git")
  installVimPackage("https://github.com/pangloss/vim-javascript.git")

def installDotfiles():
  #nothing yet
  cwd = os.getcwd()
  if 'macsetup' not in cwd[len('macsetup') * -1:]:
    print 'Not in the right dir!'
    exit()
  print 'fail'

#Utilities
def makedirs(path):
  if not os.path.exists(path):
    os.makedirs(path)


if __name__ == "__main__":
  checkBrew()
  installBrewPackage('repo')
  installBrewPackage('macvim')
  installVimFiles()
  installDotfiles()
