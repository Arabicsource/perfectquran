# frozen_string_literal: true

OmniAuth.config.test_mode = true
OmniAuth.config.logger = Logger.new('/dev/null')

OmniAuth.config.add_mock(
  :twitter,
  uid: 'uid12345',
  info: { name: 'name123', nickname: 'nickname123', image: 'image123', description: 'description123' },
  credentials:
    {
      token: '6789',
      secret: 'abcdef'
    }
)
