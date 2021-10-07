class Task < ApplicationRecord
    belongs_to :user, optional: true
    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings, source: :label

    validates :name, presence: true
    # validates :details, presence: true
    # validates :status, presence: true
    
    enum priority: {low: 0, medium: 1, high: 2}
    
    scope  :order_by_created_at, ->  {order(created_at: :desc)}
    scope  :order_by_deadline,  ->  {order(expiry_date: :desc)}
    scope  :order_by_ty_button,  ->  {order(priority: :desc)}
    scope  :order_by_priority,  ->  (priority){where(priority: priority)}
    scope  :order_by_status,  ->  (status){where(status: status)}
    scope  :title_search, -> (search_key){where("name LIKE ?","%#{search_key}%")}
    scope :label_search, -> (search_label){
        tasks = Labeling.where(label_id: search_label)
        ids = tasks.map{ |task| task.task_id } 
        where(id: ids)
    }
    
    paginates_per 5
    
    belongs_to :user
    has_many :labelings, dependent: :destroy
    has_many :labels, through: :labelings, source: :label


end
