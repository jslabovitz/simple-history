require 'minitest/autorun'
require 'minitest/power_assert'

require 'simple-history'

class Test < MiniTest::Test

  TmpDir = 'test/tmp'
  HistoryFile = File.join(TmpDir, 'history.json')

  def setup
    FileUtils.rmtree(TmpDir) if File.exist?(TmpDir)
    FileUtils.mkpath(TmpDir)
    @history = Simple::History.new(HistoryFile)
    @time = Time.now
    @a_time = @time - 20
    @b_time = @time - 10
    @c_time = @time
    @history['a'] = @a_time
    @history['b'] = @b_time
    @history.save
  end

  def test_include
    assert { @history.include?('a') }
  end

  def test_fetch
    assert { @history['a'] == @a_time }
  end

  def test_store
    @history['c'] = @c_time
    assert { @history.include?('c') && @history['c'] == @c_time }
  end

  def test_save_load
    @history.save
    @history = Simple::History.new(HistoryFile)
    assert { @history['a'] && @history['b'] }
  end

  def test_prune
    @history.prune(before: @b_time)
    assert { @history.keys == ['b'] }
  end

  def test_reset
    @history.reset
    assert { @history.keys.empty? }
  end

  def test_latest
    assert { @history.latest_entry == ['b', @b_time] }
    assert { @history.latest_time == @b_time }
    assert { @history.latest_key == 'b' }
  end

end