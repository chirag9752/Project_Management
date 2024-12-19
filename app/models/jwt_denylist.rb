class JwtDenylist < ApplicationRecord
    # Implements a token blacklist for JWT revocation
    include Devise::JWT::RevocationStrategies::Denylist

validates :jti, presence: true
end
