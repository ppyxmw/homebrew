require "formula"

class Vmalloc < Formula
  homepage "http://www2.research.att.com/sw/download/"
  url "http://www2.research.att.com/~astopen/download/tgz/vmalloc.2013-05-31.tgz",
    :user => "I accept www.opensource.org/licenses/eclipse:."
  sha1 "c656a820503c2f6e7ec19d6b42f2fa0fcefc33b0"
  version "2013-05-31"

  def install
    # Vmalloc makefile does not work in parallel mode
    ENV.deparallelize
    # override Vmalloc makefile flags
    inreplace Dir["src/**/Makefile"] do |s|
      s.change_make_var! "CC", ENV.cc
      s.change_make_var! "CXFLAGS", ENV.cflags
      s.change_make_var! "CCMODE", ""
    end
    # make all Vmalloc stuff
    system "/bin/sh ./Runmake"
    # install manually
    # put all includes into a directory of their own
    (include + "vmalloc").install Dir["include/*.h"]
    lib.install Dir["lib/*.a"]
    man.install "man/man3"
  end

  def caveats; <<-EOS.undent
    We agreed to the Eclipse Public License 1.0 for you.
    If this is unacceptable you should uninstall.
    EOS
  end
end
