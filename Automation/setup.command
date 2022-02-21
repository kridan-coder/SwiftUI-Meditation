# find current directory parent
DIR="$( cd "../$( dirname "${BASH_SOURCE[0]}" )" $$ pwd )"

cd "$DIR"

# install HomeBrew if needed
if hash brew 2>/dev/null; 
then
    echo HomeBrew is installed
else    
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install xcodegen if needed
if hash xcodegen 2>/dev/null; 
then
    echo xcodegen is installed
else    
    brew install xcodegen
fi

# install SwiftLint if needed
if hash swiftlint >/dev/null;
then
   echo swiftlint is installed
else
   brew install swiftlint
fi

#install swiftformat if needed
if hash swiftformat >/dev/null; 
then
    echo swiftformat is installed
else    
    brew install swiftformat
fi

# generate project
xcodegen generate