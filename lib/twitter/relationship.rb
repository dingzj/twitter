require 'twitter/base'
require 'twitter/user'

module Twitter
  class Relationship < Twitter::Base

    # @return [Twitter::User]
    def source
      @source ||= Twitter::User.get_or_new(@attrs['source']) unless @attrs['source'].nil?
    end

    # @return [Twitter::User]
    def target
      @target ||= Twitter::User.get_or_new(@attrs['target']) unless @attrs['target'].nil?
    end

  end
end
