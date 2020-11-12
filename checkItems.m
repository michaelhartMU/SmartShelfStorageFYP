function [item, eDates, stockActual, stockFull, expired, lowstock, outofstock] = checkItems(EPCASCII)
%test = {'item01201120200230', 'item02011120200030', 'item03201120212530', 'item03241020202830'};

%pre-allocating
expired = zeros(1,size(EPCASCII,2));
lowstock = zeros(1,size(EPCASCII,2));
outofstock = zeros(1,size(EPCASCII,2));

    for i=1:size(EPCASCII,2)
        itemString = char(EPCASCII(i));
        itemString = itemString(~isspace(itemString)); %get rid of spaces
        
        % Item name
        item{i} = cellstr(itemString(1:6));
        
        % Checking the expiry date
        currentDate = today('datetime');
        expiryDate = datetime(itemString(7:14),'InputFormat','ddMMyyyy');
        eDates{i} = datestr(expiryDate);
        expired(i) = expiryDate < currentDate;
        
        % Checking stock levels
        stockLevel_Actual = str2double(itemString(15:16));
        stockActual{i} = num2str(stockLevel_Actual);
        stockLevel_Full = str2double(itemString(17:18)); 
        stockFull{i} = num2str(stockLevel_Full);
        
        lowstock(i) = (stockLevel_Actual/stockLevel_Full) < 0.20 && (stockLevel_Actual/stockLevel_Full) > 0;
        outofstock(i) = (stockLevel_Actual/stockLevel_Full) == 0;
    end  
end