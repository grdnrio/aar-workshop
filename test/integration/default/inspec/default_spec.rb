describe package('apache2') do
  it { should be_installed }
end

describe package('mysqld') do
  it { should be_installed }
end

describe package('unzip') do
  it { should be_installed }
end
