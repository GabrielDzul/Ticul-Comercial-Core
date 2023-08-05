module UserServices
  class Activate
    def initialize
      @repo = UserRepository.instance
    end

    def execute(activation_code:)
      user = @repo.find_by!(activation_code:)
      @repo.update_from_params!(id: user.id, activation_code: nil,
                                activation_date: Time.current)
    end
  end
end