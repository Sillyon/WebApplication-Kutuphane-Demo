using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LibraryProject
{
    public class Book
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Author { get; set; }
        public bool InLibrary { get; set; }


    }

    public class BookHelper
    {
        static List<Book> _Books = null;

        public static List<Book> Books
        {
            get
            {
                if (_Books == null)
                {
                    _Books = new List<Book>();
                }
                return _Books;
            }
        }

        public Guid Add(Book book)
        {
            book.Id = Guid.NewGuid();
            Books.Add(book);

            return book.Id;
        }
    }


}