class HomeController < ApplicationController

  def buscar
    tag = params[:tag]
    access_token = params[:access_token]

    if tag.nil? || access_token.nil?
      render json: { error: "Falta parametro 'tag' o 'access_token'" }, status: 400
      return
    end

    render json:
    {
      metadata: { total: get_total(tag, access_token)},
      posts: get_posts(tag, access_token),
      version: '1.1.0'
    }
  end

  private

  def get_posts(tag, access_token)
    r = RestClient.get "https://api.instagram.com/v1/tags/#{tag}/media/recent?access_token=#{access_token}"
    response = JSON.parse(r)
    posts = []
    response['data'].each  do |post|
      tags = post['tags']
      username = post['caption']['from']['username'].to_s
      likes = post['likes']['count'].to_i
      url = post['images']['thumbnail']['url'].to_s
      caption = post['caption']['text'].to_s
      retorno = {tags: tags, username: username, likes: likes, url: url, caption: caption}
      posts << retorno
    end
    posts
  end

  def get_total(tag, access_token)
    r = RestClient.get "https://api.instagram.com/v1/tags/#{tag}?access_token=#{access_token}"
    response = JSON.parse(r)
    response['data']['media_count'].to_i
  end

end
