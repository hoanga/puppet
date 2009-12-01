module Puppet
    Puppet::Type.type(:file).newproperty(:type) do
        require 'etc'
        desc "A read-only state to check the file type."

        #munge do |value|
        #    raise Puppet::Error, ":type is read-only"
        #end

        def retrieve
            currentvalue = :absent

            if ::RUBY_VERSION =~ /1.9/
              stat = @resource.stat
            else
              stat = @resource.stat(false)
            end

            if stat
                currentvalue = stat.ftype
            end
            # so this state is never marked out of sync
            @should = [currentvalue]
            return currentvalue
        end


        def sync
            raise Puppet::Error, ":type is read-only"
        end
    end
end

