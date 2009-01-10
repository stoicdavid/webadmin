require 'test_helper'

class NeuroMailerTest < ActionMailer::TestCase
  test "registra_doctor" do
    @expected.subject = 'NeuroMailer#registra_doctor'
    @expected.body    = read_fixture('registra_doctor')
    @expected.date    = Time.now

    assert_equal @expected.encoded, NeuroMailer.create_registra_doctor(@expected.date).encoded
  end

  test "informa_paciente" do
    @expected.subject = 'NeuroMailer#informa_paciente'
    @expected.body    = read_fixture('informa_paciente')
    @expected.date    = Time.now

    assert_equal @expected.encoded, NeuroMailer.create_informa_paciente(@expected.date).encoded
  end

end
