require 'pdf/writer'
require 'pdf/simpletable'

require 'spreadsheet/excel'
include Spreadsheet

class BillsController < ApplicationController
  include ReportSystem
  include PdfReportSystem

  # GET /bills
  # GET /bills.xml
  def index
    @bills = Bill.paginate(
                           :page => params[:page],
                           :per_page => PER_PAGE,
                           :order => 'created_at DESC')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "primary-content" }
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.xml
  def new
    @bill = Bill.new

    respond_to do |format|
      format.html { render :layout => "primary-content" }
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
    render :layout => "primary-content"
  end

  # POST /bills
  # POST /bills.xml
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        flash[:notice] = 'Bill was successfully created.'
        format.html { redirect_to(@bill) }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.xml
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        flash[:notice] = 'Bill was successfully updated.'
        format.html { redirect_to(@bill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "primary-content"  }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.xml
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
    end
  end

  def list_for_company
    @bills = Bill.list_for_company(params[:company_id]).paginate(
                                                                 :page => params[:page],
                                                                 :per_page => PER_PAGE,
                                                                 :order => 'created_at DESC')
  end

  def pdf
    pdf_report(Bill.find(:all),
               "A4",
               t('common-actions.report-of') + t('menu.bills'),
               15,
               ["col1", "col2", "col3"],
               'bills'
               )
  end
end
