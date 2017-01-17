class CredsController < ApplicationController
  DENTALSQUID_AES_KEY = "a7103df8e80a0e10d2118fc0d92e5f19"
  DENTALSQUID_AES_IV = "HS0WEQK64blwX9Z7wLYnzg=="
  def new
  end
  def create
    pEmail = encrypt_str(params['pEmail']) if params['pEmail'] != ''
    pPassword = encrypt_str(params['pPassword']) if params['pPassword'] != ''
    sEmail = encrypt_str(params['sEmail']) if params['sEmail'] != ''
    sPassword = encrypt_str(params['sPassword']) if params['sPassword'] != ''
    dEmail = encrypt_str(params['dEmail']) if params['dEmail'] != ''
    dPassword = encrypt_str(params['dPassword']) if params['dPassword'] != ''
    hEmail = encrypt_str(params['hEmail']) if params['hEmail'] != ''
    hPassword = encrypt_str(params['hPassword']) if params['hPassword'] != ''
    bEmail = encrypt_str(params['bEmail']) if params['bEmail'] != ''
    bPassword = encrypt_str(params['bPassword']) if params['bPassword'] != ''
    @cred = Cred.new(user_id: session[:cred_user_id], patterson_u: pEmail, patterson_p: pPassword, safco_u: sEmail, safco_p: sPassword, darby_u: dEmail, darby_p: dPassword, henry_u: hEmail, henry_p: hPassword, benco_u: bEmail, benco_p: bPassword)
    if @cred.save
      @user = User.find(session[:cred_user_id])
      session[:user_id] = @user.id
      @c = Cart.find_by(user_id: @user.id)
        if @c.nil?
          Cart.create(user_id: @user.id)
        end
      redirect_to '/'
    else
      redirect_to :back
    end
  end
  def edit
    @cred = Cred.find_by(user_id: session[:user_id])
    @retCred = {}
    @retCred['pEmail'] = decrypt_str(@cred.patterson_u) if @cred['patterson_u']
    @retCred['pPassword'] = decrypt_str(@cred.patterson_p) if @cred['patterson_p']
    @retCred['sEmail'] = decrypt_str(@cred.safco_u) if @cred['safco_u']
    @retCred['sPassword'] = decrypt_str(@cred.safco_p) if @cred['safco_p']
    @retCred['dEmail'] = decrypt_str(@cred.darby_u) if @cred['darby_u']
    @retCred['dPassword'] = decrypt_str(@cred.darby_p) if @cred['darby_p']
    @retCred['hEmail'] = decrypt_str(@cred.henry_u) if @cred['henry_u']
    @retCred['hPassword'] = decrypt_str(@cred.henry_p) if @cred['henry_p']
    @retCred['bEmail'] = decrypt_str(@cred.benco_u) if @cred['benco_u']
    @retCred['bPassword'] = decrypt_str(@cred.benco_p) if @cred['benco_p']
    @retCred
  end
  def update
    @cred = Cred.find_by(user_id: session[:user_id])
    @cred['patterson_u'] = encrypt_str(params['pEmail']) if params['pEmail'] != ''
    @cred['patterson_p'] = encrypt_str(params['pPassword']) if params['pPassword'] != ''
    @cred['safco_u'] = encrypt_str(params['sEmail']) if params['sEmail'] != ''
    @cred['safco_p'] = encrypt_str(params['sPassword']) if params['sPassword'] != ''
    @cred['darby_u'] = encrypt_str(params['dEmail']) if params['dEmail'] != ''
    @cred['darby_p'] = encrypt_str(params['dPassword']) if params['dPassword'] != ''
    @cred['henry_u'] = encrypt_str(params['hEmail']) if params['hEmail'] != ''
    @cred['henry_p'] = encrypt_str(params['hPassword']) if params['hPassword'] != ''
    @cred['benco_u'] = encrypt_str(params['bEmail']) if params['bEmail'] != ''
    @cred['benco_p'] = encrypt_str(params['bPassword']) if params['bPassword'] != ''
    @cred.save
    redirect_to :back
  end
  def encrypt_str(str)
    return URI.escape(AES.encrypt(str, DENTALSQUID_AES_KEY, {:iv => DENTALSQUID_AES_IV}))
  end
  def decrypt_str(token)
    return AES.decrypt(URI.unescape(token).gsub(" ","+"), DENTALSQUID_AES_KEY)
  end
end
