#!/bin/bash
#
# Copyright (c) 2013  Daniel Feldle
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

# Usage Program
function usage(){
cat <<EOF
usage: $0 options

OPTIONS:
  -h  Show this message
  -s  Size of password (default 12)

EOF
}

# Manage param
PASSWD_SIZE=
while getopts "h:s:" OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        s)
            PASSWD_SIZE=$OPTARG
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done


# Default value
if [[ -z $PASSWD_SIZE ]]; then
    PASSWD_SIZE=12
fi

# Main Program
M="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
while [ "${n:=1}" -le "$PASSWD_SIZE" ]
do  
    pass="$pass${M:$(($RANDOM%${#M})):1}"
    let n+=1
done

echo $pass
