class BaseRepository
  include Singleton

  #
  # Method thar retuns all active objects
  #
  # @return [Arrat<Object>, nil]
  #
  delegate :all, to: :@db_client

  #
  # Method that return all objects thar are not deleted
  #
  # @return [Object,nil]
  #
  delegate :where, to: :@db_client
  alias query where

  #
  # Return an element based on it's id
  #
  # @return [Object, nil]
  #
  delegate :find, to: :@db_client

  #
  # Returns elements based on parameters
  #
  # @return [Object,nil]
  #
  delegate :find_by, to: :@db_client

  #
  # Returns elements based on parameters
  #
  # @return [Object]
  #
  # @raise [ActiveRecord::RecordNotFound]
  #
  delegate :find_by!, to: :@db_client

  #
  # Method thar searches or saves and object
  #
  # @param [Array<Hash>] params object params
  # @param [block] block
  #
  # @return [Object] created object
  #
  # @raises [ActiveRecord::RecordInvalid]
  #
  delegate :find_or_create_by!, to: :@db_client

  delegate :exists?, to: :@db_client

  #
  # Method that saves and object
  #
  # @param [Object]
  #
  # @return [Boolean]
  #
  # @raise [ActiveRecord::RecordInvalid]
  # @raise [ActiveRecord::RecordNotSaved]
  #
  def create!(object)
    raise ArgumentError unless object.is_a?(@db_client)
    raise ActiveRecord::RecordInvalid, object unless object.valid?

    save_object(object)
  end

  def create_from_params!(**params)
    @db_client.create!(**params)
  end

  def where_first_or_create!(params, attributes = nil, &)
    @db_client.where(params).first_or_create!(attributes, &)
  end

  def update!(object)
    raise ArgumentError, object.class.name if !object.is_a?(@db_client) || object.id.blank?

    raise ActiveRecord::RecordInvalid, object unless object.valid?

    save_object(object)
  end

  def update_from_params!(id:, **params)
    object = @db_client.find_by!(id:)
    object.update!(params)

    object
  end

  def build(**params)
    @db_client.new(**params)
  end

  protected

  def initialize
    @db_client = class_object
  end

  def class_object
    model_name = self.class.to_s.gsub('Repository', '')
    Object.const_get model_name
  end

  private

  def table
    @table ||= @db_client.arel_table
  end

  def save_object(object)
    object.save
    object
  end
end
