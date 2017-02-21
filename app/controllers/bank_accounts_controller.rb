class BankAccountsController < ApplicationController
  #before_action :set_bank_account, only: [:show, :edit, :update, :destroy, :deposite]
  skip_before_filter :verify_authenticity_token

  # GET /bank_accounts
  # GET /bank_accounts.json
  def index

    if params[:name].present?
      
      @bank_account = BankAccount.where(username: params[:name])

      if @bank_account.present?
          

          session[:username] = params[:name] 

          # @bank_account_tran = Transaction.where(username: session[:username])

                sql = "select * from transactions where username= '"+session[:username]+"' "
                @result =  ActiveRecord::Base.connection.execute(sql)
        
                  #frndsid = Array.new         
                  #result.each do |row|    
                      #render plain:row['sender_id']
                   #   frndsid.push row['sender_id']
                      #break
                  #end

      else
        session[:username] = ''
        @msg = 'Not Found'

      end

    end
    
  end
  
  def logout
  
    session.clear
    redirect_to action: "index"
  end

  def getcurrentbalance
    
    @bank_account_tran = Transaction.where(username: session[:username])

      sql = "select * from transactions where username= '"+session[:username]+"' "
      @result =  ActiveRecord::Base.connection.execute(sql)
        
        sum = 0
                  #frndsid = Array.new         
         @result.each do |row|    
              #render plain:row['sender_id']
           #   frndsid.push row['sender_id']
          sum =  sum  + row['amount']
         end

      render plain: sum.inspect

  end

  def deposite
     if session[:username].present?

        $msg = ""
        if params[:amount].present?
          
          #render plain: params.inspect
           time = Time.now.to_s(:db)
          sql = "insert into transactions (username,amount,created_at,updated_at) values ('"+params[:username]+"','"+params[:amount]+"','#{time}','#{time}')"
          ActiveRecord::Base.connection.execute(sql)
          $msg = "Submitted successfully !!"
        end
    else
      redirect_to action: "index"
    end

  end

  def transfermoney

    $msg = ''
    if session[:username].present?

    if params[:fromamount].present?


      $fromamount = params[:fromamount].to_f
      $username   = session[:username]

      $toamount     = params[:toamount].to_f
      $tousername   = params[:tousername]


      sql = "select * from bankaccount where username= '"+$tousername+"' "
      @result =  ActiveRecord::Base.connection.execute(sql)
      
      if @result.blank?        
      
         $msg = "Entered Invalid account"

      else
         
           if $fromamount < $toamount

                $msg =  "Please Enter Less Amount"
              else

                 # to user get all amount sum

                     sumto =  $toamount.to_f
                 # end 
              
                 # to credit

              $creditamount = sumto              
                  
      time = Time.now.to_s(:db)
      sqlupdateto = "insert into transactions (username,amount,created_at,updated_at) values ('"+$tousername+"',#$creditamount,'#{time}','#{time}')"
      ActiveRecord::Base.connection.execute(sqlupdateto)

                  # end

                  # debit
              $deduction =  '-'+$toamount.to_s

              $deduction = $deduction.to_f

                  
              time = Time.now.to_s(:db)
      sqlupdateto = "insert into transactions (username,amount,created_at,updated_at) values ('"+$username+"',#$deduction,'#{time}','#{time}')"
      ActiveRecord::Base.connection.execute(sqlupdateto)

                  #end

                $msg =  "Successfully Transfered to "+ $tousername

              end         
        end

    end 

      sql = "select sum(amount) as curramount from transactions where username = '"+session[:username]+"' "
      @result =  ActiveRecord::Base.connection.execute(sql)        

      if @result[0].present?
        @totalAmonut = @result[0]['curramount']
      else
        @totalAmonut = 0
      end

    else
      redirect_to action: "index"
    end

      #render plain: @totalAmonut.inspect

  end

  def getstatement

    if session[:username].present?
    
      sql = "select * from transactions where username = '"+session[:username]+"' "
      @result =  ActiveRecord::Base.connection.execute(sql) 

    else
      @result = ""
    end

  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.json
  def show
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
  end

  # GET /bank_accounts/1/edit
  def edit
  end

  # POST /bank_accounts
  # POST /bank_accounts.json
  def create
    @bank_account = BankAccount.new(bank_account_params)

    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully created.' }
        format.json { render :show, status: :created, location: @bank_account }
      else
        format.html { render :new }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1
  # PATCH/PUT /bank_accounts/1.json
  def update
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to @bank_account, notice: 'Bank account was successfully updated.' }
        format.json { render :show, status: :ok, location: @bank_account }
      else
        format.html { render :edit }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.json
  def destroy
    @bank_account.destroy
    respond_to do |format|
      format.html { redirect_to bank_accounts_url, notice: 'Bank account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_account_params
      params.require(:bank_account).permit(:username)
    end
end
