gem "minitest"
require 'minitest/autorun'
require './sec_shell.rb'

class Test_sshell<Minitest::Test

  def test_mkdir
    #Pre
    assert(!(Secure_shell.exec("ls").include? "test"))

    Secure_shell.exec("mkdir test")
    
    #Post
    assert(Secure_shell.exec("ls").include? "test")

    Secure_shell.exec("rmdir test") 
  end 

  def test_ls
    file = File.open("test", "w")
   
    #Pre

    #Post
    assert_equal(Secure_shell.exec("ls").include? "test")

    Secure_shell.exec("rm test")
  end

  def test_rm
    file = File.open("test", "w")
    
    #Pre
    assert(Secure_shell.exec("ls").include? "test")

    Secure_shell.exec("rm test")
    
    #Post
    assert(!(Secure_shell.exec("ls").include? "test"))
  end

  def test_rmdir
    Secure_shell.exec("mkdir test")
    
    #Pre
    assert(Secure_shell.exec("ls").include? "test")

    Secure_shell.exec("rmdir test")

    #Post
    assert(!(Secure_shell.exec("ls").include? "test"))
  end

  def test_cp
    file = File.open("test", "w"){puts "a"}
    
    #Pre
    assert(Secure_shell.exec("ls").include? "test")
    assert(!(Secure_shell.exec("ls").include? "test2"))    

    Secure_shell.exec(cp test.txt test2.txt)

    #Post
    assert_true(File.identical?("test", "test2"))

    Secure_shell.exec("rm test")
    Secure_shell.exec("rm test2")
  end

  def test_cd
    Secure_shell.exec("mkdir test")
    cur = Dir.pwd
    
    #Pre
    assert(Secure_shell.exec("ls").include? "test")
    
    
    Secure_shell.exec("cd test")

    #Post
    assert_equal(cur + "/test", Dir.pwd)

    Secure_shell.exec("cd ..")   
    Secure_shell.exec("rmdir test")
  end
end