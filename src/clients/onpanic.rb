# encoding: utf-8

# Copyright (c) 2012 Novell, Inc.
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact Novell, Inc.
#
# To contact Novell about this file by physical or electronic mail, you may
# find current contact information at www.novell.com.

# File:	clients/onpanic.ycp
# Package:	Configuration of onpanic
# Summary:	Main file
# Authors:	Tim Hardeck <thardeck@suse.de>
#
# $Id: irda.ycp 22889 2005-04-01 09:12:51Z jsuchome $
#
# Main file for onpanic configuration. Uses all other files.
module Yast
  class OnpanicClient < Client
    def main
      Yast.import "UI"

      #**
      # <h3>Configuration of onpanic</h3>

      textdomain "s390"

      # The main ()
      Builtins.y2milestone("----------------------------------------")
      Builtins.y2milestone("OnPanic module started")

      Yast.import "CommandLine"
      Yast.import "OnPanic"

      Yast.include self, "s390/onpanic/ui.rb"

      @cmdline_description = {
        "id"         => "onpanic",
        # Command line help text for the Xirda module
        "help"       => _(
          "Configuration of OnPanic"
        ),
        "guihandler" => fun_ref(method(:OnPanicSequence), "symbol ()"),
        "initialize" => fun_ref(OnPanic.method(:Read), "boolean ()"),
        "finish"     => fun_ref(OnPanic.method(:Write), "boolean ()"),
        "actions" =>
          # FIXME TODO: fill the functionality description here
          {},
        "options" =>
          # FIXME TODO: fill the option descriptions here
          {}
      }


      # main ui function
      @ret = CommandLine.Run(@cmdline_description)

      #ret = OnPanicSequence ();
      Builtins.y2debug("ret=%1", @ret)

      # Finish
      Builtins.y2milestone("OnPanic module finished")
      Builtins.y2milestone("----------------------------------------")

      deep_copy(@ret) 

      # EOF
    end
  end
end

Yast::OnpanicClient.new.main
