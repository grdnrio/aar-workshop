describe package('apache2') do
  it { should be_installed }
end

describe package('mysql-server') do
  it { should be_installed }
end

describe package('unzip') do
  it { should be_installed }
end

describe package('libapache2-mod-wsgi') do
  it { should be_installed }
end

describe package('python-pip') do
  it { should be_installed }
end

describe package('python-mysqldb') do
  it { should be_installed }
end

describe file('/var/www/AAR') do
  it { should be_directory }
  it { should be_owned_by 'www-data' }
  it { should be_grouped_into 'www-data' }
end
