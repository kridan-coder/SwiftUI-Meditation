START_TIME=$(date +%s)

if hash xcodegen 2>/dev/null;
then
	echo xcodegen is installed
else
	echo xcodegen is not installed, run setup.command
fi

xcodegen generate

END_TIME=$(date +%s)
ELAPSED_TIME=$(( $END_TIME - $START_TIME ))

echo "Xcodegen worked for \033[1;32m$ELAPSED_TIME\033[0m seconds"