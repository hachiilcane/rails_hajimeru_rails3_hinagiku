# -*- coding: utf-8 -*-
names = [
         "切手を買う",
         "報告書を書く",
         "家賃を払う",
         "猫のえさを買う",
         "燃えないごみを出す"
]

description = "これは説明です。" * 20

5.times do |n|
  Task.create(:name => names[n], :description => description,
              :due_date => (n - 2).days.from_now, :done => n.zero?)
end

200.times do |n|
  Task.create(:name => "Task #{n}", :description => description,
              :due_date => (n + 3).days.from_now, :done => false)
end

%w(仕事 生活 趣味).each do |name|
  Category.create(:name => name)
end

tasks = Task.order('id').limit(5).all
categories = Category.order('id').all

categories[1].tasks << tasks[0]
categories[0].tasks << tasks[1]
categories[1].tasks << tasks[2]
categories[1].tasks << tasks[4]
