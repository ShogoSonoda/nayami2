require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      region: 'ap-northeast-1',
      path_style: true
    }
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = 'nayami2-avatar'
    config.asset_host = 'https://static.nayami2app.com'
  end
end