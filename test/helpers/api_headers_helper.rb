module ApiHeadersHelper
  def headers_v1(uid = nil, token = nil, client = nil)
    header = {
        'API-VERSION': 1,
        'Accept': 'application/json'
      }
    return header unless uid || token || client

    header.merge({ 'uid': uid , 'access-token': token, 'client': client })
  end
end
