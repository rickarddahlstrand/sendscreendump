#!/bin/bash
# Copyright (c) 2012, Rickard Dahlstrand, Tilde, rd@tilde.se
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#    This product includes software developed by the Rickard Dahlstrand, Tilde.
# 4. Neither the name of the <organization> nor the
#    names of its contributors may be used to endorse or promote products
#    derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY Rickard Dahlstrand, Tilde ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Rickard Dahlstrand, Tilde, BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

echo "Making dir and mounting"
mkdir /tmp/iorweb

# Change PORT, USER and SERVER below to the your liking. Also update the path of the webserver directory on the server.
./sshfs-static -p PORT USER@SERVER:/var/www/htdocs /tmp/iorweb -oauto_cache,reconnect,transform_symlinks,follow_symlinks,negative_vncache,workaround=nonodelay
echo "Starting loop (press any key to abort)"
for (( ; ; ))
do

# Use this if the performance of the client goes down to much, affects referesh rate.
   screencapture -T3 -tjpg /tmp/iorweb/screendump.jpg

# Use this if the performance of the client is ok, sends updated as fast as possible.
#   screencapture -x -tjpg /tmp/iorweb/screendump.jpg

   read -t 1 -n 1 keypress
   if [ "$keypress" != "" ]
   then
     break  # Skip entire rest of loop.
   fi
done
echo "Done, unmounting.."
cp please-stand-by.jpg /tmp/iorweb/screendump.jpg
umount /tmp/iorweb
rmdir /tmp/iorweb
