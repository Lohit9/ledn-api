class Types::Enum::AccountHolderSort < Types::BaseEnum
  value "amtAsc", value: [:amt, :asc]
  value "amtDesc", value: [:amt, :desc]
  value "createdDateAsc", value: [:createdDate, :asc]
  value "createdDateDesc", value: [:createdDate, :desc]
end
