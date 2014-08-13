#
# There are two mutualy exclusive registration requirements for a given user
#  1 The first is that the database is empty, in this case the user can be the first to
#     be added to the users table, and they do not require being added manualy by an existing user.
#  2 The next is that the email is already contained in the authorization table
#
# This script is inverted from other Transcation scripts
# the default return is a failure not a success; this is for security reasons.
class UserPreauthScript < TransactionScript
  def run(params)

    if User.all.empty?
      return success(
        user: User.from_omniauth(params[:auth]),
        meta: "empty table, first user strategy used"
      )
    end

    if User.find_by(email: params[:auth]['info']['email'])
      return success(
        user: User.from_omniauth(params[:auth]),
        meta: "user discovered/preautherized strategy used"
      )
    end

    return failure(error: :preauth_requirements_not_met)
  end
end
