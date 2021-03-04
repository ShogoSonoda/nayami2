class Position < ActiveHash::Base
  
  self.data = [
    { id: 1, name: '新入社員' },
    { id: 2, name: '一般社員' },
    { id: 3, name: '主任' },
    { id: 4, name: '係長' },
    { id: 5, name: '課長' }
  ]

end