#!/bin/bash
#
# Copyright (c) 2013 Daniel Feldle
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.



function usage() {
cat <<EOF
usage: $0 options

OPTIONS:
  -h  Show this message
  -f  Name of new script
  -o  Option flag 

EOF
}

# Parse Param
while getopts "hof:" OPTION
do
        case $OPTION in
                h)
                        usage
                        exit 1
                        ;;
                f)
                        FILENAME=$OPTARG
                        ;;
		o)
			OPTION_FLAG=1
			;;	
                ?)
                        usage
                        exit 1
                        ;;
        esac
done

# Main
if [ -z $FILENAME ]; then
        usage;
        exit 1
elif [ -e "$FILENAME.sh" ] && [ -f "$FILENAME.sh"  ]; then
        echo "$FILENAME already exist"
else
        echo "Create file $FILENAME.sh"
        echo "#!/bin/bash
#
# Copyright (c) $(date +%Y)  Daniel Feldle
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the \"Software\"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE." > $FILENAME".sh"

        # Add Options
    	if [ ! -z $OPTION_FLAG ]; then
    		echo "Add option bloc"
            echo "
function usage() {
        cat <<EOF
usage: \$0  options

OPTIONS:
  -h  Show this message

EOF
}

# Parse Param
while getopts \"h:\" OPTION
do
        case \$OPTION in
                h)
                        usage
                        exit 1
                        ;;
                ?)
                        usage
                        exit 1
                        ;;
        esac
done

# Main Program
if [ -z \$1 ]; then
        usage;
        exit 1
else
        echo \"Write here your programm\"
fi" >> $FILENAME".sh"
    	fi

        echo "Change permission"
        chmod u+x $FILENAME".sh"
fi


# test