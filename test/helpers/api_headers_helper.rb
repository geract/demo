module ApiHeadersHelper
  def headers_v1(uid, token, client)
    {'API-VERSION' => '1', 'uid' => uid, 'access-token' => token, 'client' => client }
  end
end
