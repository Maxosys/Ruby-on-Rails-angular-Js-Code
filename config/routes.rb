
Rails.application.routes.draw do
  root 'bank_accounts#index'
  get  '/'						=> 'bank_accounts#index'
  post  '/index'				=> 'bank_accounts#index'
  post  '/getvalid'				=> 'bank_accounts#getvalid'
  get  'logout'					=> 'bank_accounts#logout'
  get  '/deposite'				=> 'bank_accounts#deposite'
  post  '/deposite'				=> 'bank_accounts#deposite'
  get  '/getcurrentbalance'		=> 'bank_accounts#getcurrentbalance'
  post  '/getcurrentbalance'	=> 'bank_accounts#getcurrentbalance'
  get  '/transfermoney'			=> 'bank_accounts#transfermoney'
  post  '/transfermoney'		=> 'bank_accounts#transfermoney'
  get  '/getstatement'			=> 'bank_accounts#getstatement'
  post  '/getstatement'			=> 'bank_accounts#getstatement'
  
  resources :bank_accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
