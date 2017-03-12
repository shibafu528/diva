# -*- coding: utf-8 -*-

=begin rdoc
=Model用のURIクラス

mikutterでは、 URI や Addressable::URI の代わりに、このクラスを使用します。
URI や Addressable::URI に比べて、次のような特徴があります。

* コンストラクタに文字列を渡している場合、 _to_s_ がその文字列を返す。
  * 正規化しないかわりに高速に動作します。
* Diva::URI のインスタンスは URI と同じように使える
* unicode文字などが入っていて URI では表現できない場合、 Addressable::URI を使う
  * Addressable::URIでないと表現できないURIであればそちらを使うという判断を自動で行う

== 使い方
Diva::URI() メソッドの引数にString, URI, Addressable::URI, Hash, Diva::URIのいずれかを与えます。

[String] uriの文字列(ex: "http://mikutter.hachune.net/")
[URI] URI のインスタンス
[Addressable::URI] Addressable::URI のインスタンス
[Hash] これを引数にURI::Generic.build に渡すのと同じ形式の Hash
[Diva::URI] 即座にこれ自身を返す

== 例

    Diva::URI("http://mikutter.hachune.net/")
    Diva::URI(URI::Generic.build(scheme: 'http', host: 'mikutter.hachune.net'))
=end

class Diva::URI
  def initialize(uri)
    case uri.freeze
    when *uri_types
      @uri = uri
    when String
      @uri_string = uri
    when Hash
      @uri_hash = uri
    end
  end

  def ==(other)
    case other
    when *uri_types
      other == to_uri
    when Diva::URI
      if has_string? or other.has_string?
        to_s == other.to_s
      else
        other.to_uri == to_uri
      end
    end
  end

  def hash
    to_s.hash ^ self.class.hash
  end

  def has_string?
    !!@uri_string
  end

  def has_uri?
    !!@uri
  end

  def to_s
    @uri_string ||= to_uri.to_s.freeze
  end

  def to_uri
    @uri ||= generate_uri.freeze
  end

  def scheme
    if has_string? and !has_uri?
      match = @uri_string.match(%r<\A(\w+):>)
      if match
        match[1]
      else
        to_uri.scheme
      end
    else
      to_uri.scheme
    end
  end

  def freeze
    unless frozen?
      to_uri
      to_s
    end
    super
  end

  def respond_to?(method)
    super or to_uri.respond_to?(method)
  end

  def method_missing(method, *rest, &block)
    to_uri.__send__(method, *rest, &block)
  end

  private

  def generate_uri
    if @uri
      @uri
    elsif @uri_string
      @uri = generate_uri_by_string
    elsif @uri_hash
      @uri = generate_uri_by_hash
    end
    @uri
  end

  def generate_uri_by_string
    ::URI.parse(@uri_string)
  rescue ::URI::InvalidComponentError
    raise unless Module.const_defined?(:Addressable)
    Addressable::URI.parse(@uri_string)
  end

  def generate_uri_by_hash
    ::URI::Generic.build(@uri_hash)
  rescue ::URI::InvalidComponentError
    raise unless Module.const_defined?(:Addressable)
    Addressable::URI.new(@uri_hash)
  end

  def uri_types
    types = []
    types << ::URI
    types << Addressable::URI if Module.const_defined?(:Addressable)
  end
end
